using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraAnimation : MonoBehaviour {

	float rotation = 0f;

	float radius = 1f;

	void Start () {
		radius = transform.localScale.y;
	}
	
		void Update () {
		rotation = radius * Time.deltaTime;
		transform.Rotate(0f, rotation, 0f);
	}

}
