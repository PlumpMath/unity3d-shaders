// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/ShaderTemp" {
	Properties {
		_Color ("Color", Color) = (1.0, 1.0, 1.0, 1.0)
		// 2
		_Value1 ("Value 1", Float) = 0.5
		_Value2 ("Value 2", Float) = 0.5
		_Value3 ("Value 3", Float) = 0.5
		// 3
		_MainTex ("Texture", 2D) = "white" { }
	}
	SubShader {
		Pass {

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			// Vertex to Fragment
			struct v2f {
				float4 position: SV_POSITION;
				float4 color: COLOR;
				//float2 uv : TEXCOORD0;
			};

			// 1
			uniform float4 _Color;
			// 2
			float _Value1;
			float _Value2;
			float _Value3;
			// 3
			sampler2D _MainTex;
			float4 _MainTex_ST;

			/* Begin of Example 1
			v2f vert(appdata_base v) {
				v2f o;
				o.position = UnityObjectToClipPos(v.vertex);
				return o;
			}

			half4 frag(v2f o): Color {
				return half4(1.0, 0.0, 0.0, 1.0);
			}
			*/


			/* Begin of Example 2
			v2f vert(appdata_base v) {
				v2f o;
				v.vertex.xyz += v.normal * _Value1;
				v.vertex.xyz += sin((v.vertex.y + _Time * _Value3) * _Value2) * _Value1;
				v.vertex.xyz += v.normal * (sin((v.vertex.x + _Time * _Value3) * _Value2) + cos((v.vertex.z + _Time * _Value3) * _Value2)) * _Value1;
				o.color = float4(v.normal, 1) * 0.5 + 0.5;
				o.position = UnityObjectToClipPos(v.vertex);
				return o;
			}

			float4 frag(v2f o): Color {
				return o.color;
			}
			*/


			/* Begin of Example 3
			v2f vert(appdata_base v) {
				v2f o;
				v.vertex.xyz += v.normal * _Value1;
				v.vertex.xyz += sin((v.vertex.y + _Time * _Value3) * _Value2) * _Value1;
				v.vertex.xyz += v.normal * (sin((v.vertex.x + _Time * _Value3) * _Value2) + cos((v.vertex.z + _Time * _Value3) * _Value2)) * _Value1;
				o.color = v.texcoord;
				o.position = UnityObjectToClipPos(v.vertex);
				// Make sure texture scale and offset is applied correctly
				o.uv = TRANSFORM_TEX (v.texcoord, _MainTex);
				return o;
			}

			// Sample the texture and multiplies by the color property
			fixed4 frag (v2f i) : SV_Target {
				fixed4 texcol = tex2D (_MainTex, i.uv);
            	return texcol * _Color;
			}
			*/


			/* Begin of Example 4 */
			v2f vert(appdata_base v) {
				v2f o;
				v.vertex.z += _Value1;

				o.color = _Color;
				o.position = UnityObjectToClipPos(v.vertex);
				return o;
			}

			// Sample the texture and multiplies by the color property
			fixed4 frag (v2f i) : SV_Target {
            	return i.color;
			}
			/**/


			ENDCG
		}
	}

	FallBack "Diffuse"
}
