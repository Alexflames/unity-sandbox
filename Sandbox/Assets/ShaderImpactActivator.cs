using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderImpactActivator : MonoBehaviour
{
    struct ImpactActivatorInfo {
        public float radius;
        public Vector3 position;

        public ImpactActivatorInfo(Vector3 position, float radius = 0)
        {
            this.radius = radius;
            this.position = position;
        }
    };

    ImpactActivatorInfo[] impacts = new ImpactActivatorInfo[5];
    int impactIndex = 0;
    int impactsCnt = 0;

    public Material material;

    public float RadiusStart = 2.0f;
    public float StopImpactRadiusValue = 10;
    
    public void ActivateVisualImpact(GameObject activator)
    {
        // Важно что y-компонента вектора берется от объекта с логикой!!
        impacts[impactIndex] = 
            new ImpactActivatorInfo(new Vector3(
                activator.transform.position.x, 
                transform.position.y % 5, 
                activator.transform.position.z));
        SetRendImpactPosition(impactIndex);
        impactIndex = (impactIndex + 1) % 5;
        impactsCnt++;
    }

    void Start()
    {
        material = gameObject.GetComponent<Renderer>().material;
        var renderers = GetComponentsInChildren<Renderer>();
        foreach (var rend in renderers)
        {
            rend.sharedMaterial = material;
        }
    }

    void OnCollisionEnter(Collision collision)
    {
        ActivateVisualImpact(collision.gameObject);
    }

    void UpdateRendRadius(int i)
    {
        material.SetFloat("_Radius" + i, impacts[i].radius);
    }

    void SetRendImpactPosition(int i)
    {
        material.SetVector("_ImpactObjPos" + impactIndex, impacts[impactIndex].position);
    }

    void Update()
    {
        for (int i = 0; i < 5 && i < impactsCnt; i++)
        {
            if (impacts[i].radius != -1)
            {
                impacts[i].radius += 6 * Time.deltaTime;
                // finish wave
                if (impacts[i].radius >= StopImpactRadiusValue) impacts[i].radius = -1;
                UpdateRendRadius(i);
            }
        }
    }
}
