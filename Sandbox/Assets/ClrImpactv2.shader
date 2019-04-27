Shader "Custom/Diffuse Simple" {
    Properties{
        _ImpactObjPos0("ImpactObjPos0", Vector) = (0, 0, 0, 0)
        _Radius0("Radius0", Float) = 5.0
        _ImpactObjPos1("ImpactObjPos1", Vector) = (0, 0, 0, 0)
        _Radius1("Radius1", Float) = 5.0
        _ImpactObjPos2("ImpactObjPos2", Vector) = (0, 0, 0, 0)
        _Radius2("Radius2", Float) = 5.0
        _ImpactObjPos3("ImpactObjPos3", Vector) = (0, 0, 0, 0)
        _Radius3("Radius3", Float) = 5.0
        _ImpactObjPos4("ImpactObjPos4", Vector) = (0, 0, 0, 0)
        _Radius4("Radius4", Float) = 5.0
    }
    SubShader{
        Tags{ "RenderType" = "Opaque" }
        CGPROGRAM
#pragma surface surf Lambert
    struct Input {
        float3 worldPos;
    };
    float3 _ImpactObjPos0;
    half _Radius0;
    float3 _ImpactObjPos1;
    half _Radius1;
    float3 _ImpactObjPos2;
    half _Radius2;
    float3 _ImpactObjPos3;
    half _Radius3;
    float3 _ImpactObjPos4;
    half _Radius4;

    void surf(Input IN, inout SurfaceOutput o) {
        // Lower the height factor
        // Makes effect look slower on walls
        float3 normPos0 = _ImpactObjPos0;
        normPos0.y = IN.worldPos.y + (IN.worldPos.y - _ImpactObjPos0.y) / 0.4;
        float3 normPos1 = _ImpactObjPos1;
        normPos1.y = IN.worldPos.y + (IN.worldPos.y - _ImpactObjPos1.y) / 0.4;
        float3 normPos2 = _ImpactObjPos2;
        normPos2.y = IN.worldPos.y + (IN.worldPos.y - _ImpactObjPos2.y) / 0.4;
        float3 normPos3 = _ImpactObjPos3;
        normPos3.y = IN.worldPos.y + (IN.worldPos.y - _ImpactObjPos3.y) / 0.4;
        float3 normPos4 = _ImpactObjPos4;
        normPos4.y = IN.worldPos.y + (IN.worldPos.y - _ImpactObjPos4.y) / 0.4;

        // Colored circles are made of this
        // y = -|R - x| + 1
        half d = distance(normPos0, IN.worldPos);
        fixed dclr0 = saturate(-abs(_Radius0 - d) + 1) * 0.5;
        d = distance(normPos1, IN.worldPos);
        fixed dclr1 = saturate(-abs(_Radius1 - d) + 1) * 0.5;
        d = distance(normPos2, IN.worldPos);
        fixed dclr2 = saturate(-abs(_Radius2 - d) + 1) * 0.5;
        d = distance(normPos3, IN.worldPos);
        fixed dclr3 = saturate(-abs(_Radius3 - d) + 1) * 0.5;
        d = distance(normPos4, IN.worldPos);
        fixed dclr4 = saturate(-abs(_Radius4 - d) + 1) * 0.5;

        o.Albedo = half3(0.5 + dclr0 + dclr1 + dclr2 + dclr3 + dclr4, 0.5, 0.5); // 1 = (1,1,1,1) = white
    }
    ENDCG
    }
        Fallback "Diffuse"
}

