Shader "Custom/ShaderComments" {
	Properties {
		_Color ("Color", Color) = (1.0, 1.0, 1.0, 1.0)  // R, G, B, A
		_MyVector ("My Vector4", Vector) = (0, 0, 0, 0) // x, y, z, w
	}
	SubShader {
		Pass {

			Tags
			{
				"Queue" = "Geometry"
				"RenderType" = "Opaque"
			}

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct v2f {
				float4 position: SV_POSITION;
			};

			uniform float4 _Color;

			v2f vert(appdata_base v) {
				v2f o;
				v.vertex.xy += v.normal * 2.0 * _Time;
				o.position = UnityObjectToClipPos(v.vertex);
				return o;
			}

			fixed4 frag (v2f i) : SV_Target {
				return fixed4(_Color);
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}
