// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Shader02" {

	Properties {
		_Color ("Color", Color) = (1.0, 1.0, 1.0, 1.0)
	}

	SubShader {
		Pass {

			CGPROGRAM

			// Pragmas
			#pragma vertex vert
			#pragma fragment frag

			// User Defined Variables
			uniform float4 _Color;

			// Base Input Structs
			struct vertexInput {
				float4 vertex : POSITION;
			};

			struct vertexOutput {
				float4 position : SV_POSITION;
			};


			// Vertex functions
			vertexOutput vert(vertexInput v) {
				vertexOutput o;
				o.position = UnityObjectToClipPos(v.vertex);
				return o;
			}

			// Fragment functions
			float4 frag(vertexOutput i) : Color {
				return _Color;
			}

			ENDCG

		}
	}

	FallBack "Diffuse"

}
