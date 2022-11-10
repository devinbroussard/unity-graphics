using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class WaterControllerBehavior : MonoBehaviour
{
    [SerializeField]
    private InputField _rippleSpeedInput;
    [SerializeField]
    private InputField _rippleDensityInput;
    [SerializeField]
    private InputField _rippleSizeInput;
    [SerializeField]
    private Slider _claritySlider;
    [SerializeField]
    private InputField _waveHeightInput;
    [SerializeField]
    private InputField _waveSpeedInput;

    [SerializeField]
    private Slider _colorRed;
    [SerializeField]
    private Slider _colorGreen;
    [SerializeField]
    private Slider _colorBlue;

    [SerializeField]
    private Slider _rippleColorRed;
    [SerializeField]
    private Slider _rippleColorGreen;
    [SerializeField]
    private Slider _rippleColorBlue;

    [SerializeField]
    private MeshRenderer _meshRenderer;

    private void Start()
    {
        Material material = _meshRenderer.material;

        _rippleSpeedInput.text = material.GetFloat("RippleSpeed").ToString();
        _rippleDensityInput.text = material.GetFloat("RippleDensity").ToString();
        _rippleSizeInput.text = material.GetFloat("RippleSlimness").ToString();
        _claritySlider.value = material.GetFloat("WaterClarity");
        _waveHeightInput.text = material.GetFloat("RippleSize").ToString();
        _waveSpeedInput.text = material.GetFloat("WaveSpeed").ToString();

        Color color = material.GetColor("BaseColor");
        _colorRed.value = color.r;
        _colorGreen.value = color.g;
        _colorBlue.value = color.b;

        Color rippleColor = material.GetColor("RippleColor");
        _rippleColorRed.value = rippleColor.r;
        _rippleColorGreen.value = rippleColor.g;
        _rippleColorBlue.value = rippleColor.b;
    }

    private void Update()
    {
        Material material = _meshRenderer.material;

        material.SetFloat("RippleSpeed", float.Parse(_rippleSpeedInput.text));

        material.SetFloat("RippleDensity", float.Parse(_rippleDensityInput.text));
        material.SetFloat("RippleSlimness", float.Parse(_rippleSizeInput.text));
        material.SetFloat("WaterClarity", _claritySlider.value);
        material.SetFloat("RippleSize", float.Parse(_waveHeightInput.text));
        material.SetFloat("WaveSpeed", float.Parse(_waveSpeedInput.text));
        material.SetColor("BaseColor", new Color(_colorRed.value, _colorGreen.value, _colorBlue.value));
        material.SetColor("RippleColor", new Color(_rippleColorRed.value, _rippleColorGreen.value, _rippleColorBlue.value));

        _meshRenderer.material = material;
    }
}
