Shader "Custom/Shader05" {

	Properties {
		 // Color property for material inspector, default to white
		_Color ("Color", Color) = (1.0, 1.0, 1.0, 1.0)
	}

	SubShader {
		Pass {

			CGPROGRAM

			// Pragmas
			#pragma vertex vert
			#pragma fragment frag

			// Include file that contains UnityObjectTonormal
			// helper function
			#include "UnityCG.cginc"

			// User Defined Variables:

			// Color from the material
			uniform float4 _Color;

			// Base Input Structs
			struct vertexInput {
				float3 normal : NORMAL;
				float4 vertex : POSITION;
			};

			struct vertexOutput {
				float4 position : SV_POSITION;
				fixed4 color : COLOR;
			};

			vertexOutput vert(vertexInput v) {
				vertexOutput o;
				o.position = UnityObjectToClipPos(v.vertex);
				o.color.xyz = v.normal * 0.5 + 0.5;
				o.color.w = 1.0;
				return o;
			}

			fixed4 frag(vertexOutput i) : SV_Target {
				return i.color;
			}

			ENDCG
		}
	}

	FallBack "Diffuse"

}
