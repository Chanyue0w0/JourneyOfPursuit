using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

using SimpleJSON;
using UnityEngine.EventSystems;
using Unity.VisualScripting;


public class DialogSystem : MonoBehaviour
{
    private AudioSource BGM;
    public AudioClip bgmKingdom; 
    public AudioClip bgmForest;
    public AudioClip bgmDesert;
    public AudioClip bgmSnow;
    public AudioClip bgmFinal;

    private static DialogSystem instance;

    private void Awake()
    {
        BGM = GetComponent<AudioSource>();
        BGM.loop = true;
        if (instance == null)
        {
            instance = this;
        }
    }

    // 切換使用的音樂
    public void SwitchBGM(string chapter)
    {
        switch (chapter)
        { 
            case "kingdom":
                PlayBGM(bgmKingdom);
                break;
            case "forest":
                PlayBGM(bgmForest);
                break;
            case "desert":
                PlayBGM(bgmDesert);
                break;
            case "snow":
                PlayBGM(bgmSnow);
                break;
            case "final":
                PlayBGM(bgmFinal);
                break;
            default:
                Debug.Log("SwitchBGM name error");
                break;
        }
    }

    // 播放指定的音樂
    private void PlayBGM(AudioClip clip)
    {
        if (clip != null)
        {
            BGM.clip = clip;
            BGM.Play();
        }
    }

    public static DialogSystem GetInstance()
    {
        return instance;
    }
}



