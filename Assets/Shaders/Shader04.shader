Shader "Custom/Shader04" {

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
				half3 worldReflect : TEXCOORD0;
			};


			// Vertex functions
			vertexOutput vert(vertexInput v) {
				vertexOutput o;
				o.position = UnityObjectToClipPos(v.vertex);
				// compute world space position of the vertex
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				// compute world space view direction
				float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
				// world space normal
				float3 normal = UnityObjectToWorldNormal(v.normal);
				// world space reflection vector
				o.worldReflect = reflect(-worldViewDir, normal);
				return o;
			}

			// Fragment functions
			// normal is a 3D vector with xyz components; in -1..1 range.
			// To display it as color, bring the range into 0..1 and
			// put into red, green, blue components
			fixed4 frag(vertexOutput o) : SV_Target {
				// sample the default reflection cubemap, using the reflection vector
				half4 skyData = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, o.worldReflect);
				// decode cubemap data into actual color
				half3 skyColor = DecodeHDR (skyData, unity_SpecCube0_HDR);
				// output it!
				fixed4 c = 0;
				c.rgb = skyColor;
				return c;
			}

			ENDCG
		}
	}

	FallBack "Diffuse"

}
