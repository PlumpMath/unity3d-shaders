﻿Shader "Custom/Shader03" {

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
				half3 normal : TEXCOORD0;
				float4 position : SV_POSITION;
				fixed4 color : COLOR;
			};


			// Vertex functions
			vertexOutput vert(vertexInput v) {
				vertexOutput o;
				// Following statement is converted to next:
				// ->    o.position = mul(UNITY_MATRIX_MVP, v.vertex);
				o.position = UnityObjectToClipPos(v.vertex);
				o.normal = UnityObjectToWorldNormal(v.normal);
				return o;
			}

			// Fragment functions
			float4 frag(vertexOutput o) : Color {
				return _Color;
			}

			ENDCG
		}
	}

	FallBack "Diffuse"

}
