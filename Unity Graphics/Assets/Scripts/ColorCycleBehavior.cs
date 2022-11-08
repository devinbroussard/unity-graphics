using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColorCycleBehavior : MonoBehaviour
{
    [SerializeField]
    [Range(0.0f, 1.0f)] 
    private float _ambientRed = 0.0f;

    [SerializeField]
    [Range(0.0f, 1.0f)]
    private float _ambientBlue = 0.0f;

    [SerializeField]
    [Range (0.0f, 1.0f)]
    private float _ambientGreen = 0.0f;

    private MeshRenderer _meshRenderer;

    private void Awake()
    {
        _meshRenderer = GetComponent<MeshRenderer>();
    }

    private void Update()
    {
        _meshRenderer.material.SetColor("_Ambient", new Color(_ambientRed, _ambientBlue, _ambientGreen));   
    }
}
