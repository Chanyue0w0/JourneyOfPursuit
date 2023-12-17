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
        // 在靜態類別的建構函式中載入設置
        LoadSettings();
    }

    private static void ApplyGlobalVolume()
    {
        // 將全局音量應用到 AudioListener
        AudioListener.volume = globalVolume;
    }

    public static void SaveSettings()
    {
        // 將設置保存到 PlayerPrefs
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

        ApplyGlobalVolume(); // 確保在設置 AudioListener 之前應用全局音量
    }
}
