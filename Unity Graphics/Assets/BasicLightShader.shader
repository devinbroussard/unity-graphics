// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/BasicLightShader"
{
    Properties
    {
        _Ambient("_Ambient", Color) = (0.1, 0.1, 0.1, 0.1)
        _Diffuse("_Diffuse", Color) = (1.0, 0.0, 0.0, 1.0)
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 normal : NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                float4 normal : NORMAL;
            };

            float4 _Ambient;
            float4 _Diffuse;
            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                // Vertex output
                v2f o;
                // Gets the clip space of the vertex (where it shows on the screen)
                o.vertex = UnityObjectToClipPos(v.vertex);
                // Send normal
                o.normal = v.normal;
                // Calculate UV
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                // Make fog work
                UNITY_TRANSFER_FOG(o,o.vertex);
                // Send output to fragment sahder
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float lambert = saturate(dot(i.normal, _WorldSpaceLightPos0));
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv) * lambert * _Diffuse + _Ambient;
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                // Send color to pixel
                return col;
            }
            ENDCG
        }
    }
}
