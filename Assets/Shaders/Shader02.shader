Shader "Custom/Shader02" {

	Properties {
		_MainTex ("Texture", 2D) = "red" {}
		_BumpMap ("Bumpmap", 2D) = "bump" {}
	}

	SubShader {

		Tags { "RenderType" = "Opaque" }
		
		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _BumpMap;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;      // Diffuse Color
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
		}

		ENDCG
	}

	FallBack "Diffuse"

}
