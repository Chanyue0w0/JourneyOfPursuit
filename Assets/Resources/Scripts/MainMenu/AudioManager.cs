using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class AudioManager
{
    private static float globalVolume = 1.0f;

    public static float GlobalVolume
    {
        get { return globalVolume; }
        set
        {
            globalVolume = Mathf.Clamp01(value); 
            ApplyGlobalVolume();
            SaveSettings();
        }
    }

    private const string PlayerPrefsKey = "GlobalVolume";

    static AudioManager()
    {
        // �b�R�A���O���غc�禡�����J�]�m
        LoadSettings();
    }

    private static void ApplyGlobalVolume()
    {
        // �N�������q���Ψ� AudioListener
        AudioListener.volume = globalVolume;
    }

    public static void SaveSettings()
    {
        // �N�]�m�O�s�� PlayerPrefs
        PlayerPrefs.SetFloat(PlayerPrefsKey, globalVolume);
        PlayerPrefs.Save();
    }

    public static void LoadSettings()
    {
        if (PlayerPrefs.HasKey(PlayerPrefsKey))
        {
            globalVolume = Mathf.Clamp01(PlayerPrefs.GetFloat(PlayerPrefsKey));
        }
        else
        {
            globalVolume = 1.0f;
        }

        ApplyGlobalVolume(); // �T�O�b�]�m AudioListener ���e���Υ������q
    }
}
