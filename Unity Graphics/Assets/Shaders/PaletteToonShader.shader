Shader "Unlit/PaletteToonShader"
{
    Properties
    {
        _Body ("Body", Color) = (1.0, 0.0, 0.0, 1.0)
        _Visor ("Visor", Color) = (0.0, 1.0, 1.0, 1.0)
        _Highlight ("Highlight Threshold", Range(0.0, 1.0)) = 0.5
        _MainTex ("Texture", 2D) = "white" {}
        _Shadow ("Shadow Threshold", Range(0.0, 1.0)) = 0.25
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
                float4 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                float4 normal : NORMAL;
            };

            fixed4 _Body;
            fixed4 _Visor;
            float _Shadow;
            float _Highlight;
            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.normal = v.normal;
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float lambert = saturate(dot(i.normal, _WorldSpaceLightPos0));
                if (lambert >= _Highlight)
                {
                    lambert = 1.0f;
                }
                else if (lambert > _Shadow) {
                    lambert = _Highlight;
                }
                else {
                    lambert = _Shadow;
                }

                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                fixed4 bodyMask = fixed4(col.x, col.x, col.x, col.w);
                fixed4 visorMask = fixed4(col.y, col.y, col.y, col.w);

                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return lambert * saturate(bodyMask * _Body + visorMask * _Visor);
            }
            ENDCG
        }
    }
}
