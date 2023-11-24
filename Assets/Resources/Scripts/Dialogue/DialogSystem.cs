using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

using SimpleJSON;
using UnityEngine.EventSystems;
using Unity.VisualScripting;


public class DialogSystem : MonoBehaviour
{
    public AudioSource BGM;
    public AudioClip bgmKingdom;
    public AudioClip bgmForest;
    public AudioClip bgmDesert;
    public AudioClip bgmSnow;
    public AudioClip bgmFinal;

    public AudioSource MUSIC;
    public AudioClip Music;

    private static DialogSystem instance;

    private void Awake()
    {
        BGM = gameObject.AddComponent<AudioSource>();
        BGM.loop = true;

        MUSIC = gameObject.AddComponent<AudioSource>();
        MUSIC.loop = true;

        bgmKingdom = Resources.Load<AudioClip>("Musics/forest");
        bgmForest = Resources.Load<AudioClip>("Musics/forest");
        //bgmDesert = Resources.Load<AudioClip>("Musics/desert");
        //bgmSnow = Resources.Load<AudioClip>("Musics/snow");
        //bgmFinal = Resources.Load<AudioClip>("Musics/final");

        if (instance == null)
        {
            instance = this;
        }
    }

    // 切換使用的音樂
    public void SwitchBGM(string chapter, float musicTime)
    {
        Debug.Log("In SwitchBGM " + chapter);
        switch (chapter)
        {
            case "kingdom":
                PlayBGM(bgmKingdom, musicTime);
                break;
            case "forest":
                PlayBGM(bgmForest, musicTime);
                break;
            case "desert":
                PlayBGM(bgmDesert, musicTime);
                break;
            case "snow":
                PlayBGM(bgmSnow, musicTime);
                break;
            case "final":
                PlayBGM(bgmFinal, musicTime);
                break;
            default:
                Debug.Log("SwitchBGM name error");
                break;
        }
    }

    // 播放指定的音樂
    private void PlayBGM(AudioClip clip, float musicTime)
    {
        if (clip != null)
        {
            Debug.Log("Playing BGM");
            BGM.clip = clip;
            BGM.time = musicTime;
            BGM.Play();
        }
    }

    public void SwitchMusic(string music, float musicTime)
    {
        Debug.Log("In SwitchMusic " + music);
        if (music == "none")
        {
            MUSIC.Stop();
        }
        else
        {
            Music = Resources.Load<AudioClip>("Musics/" + music);
            PlayMusic(Music, musicTime);
        }

    }

    private void PlayMusic(AudioClip clip, float musicTime)
    {
        if (clip != null)
        {
            Debug.Log("Playing musics");
            MUSIC.clip = clip;
            MUSIC.time = musicTime;
            MUSIC.Play();
        }
    }

    public static DialogSystem GetInstance()
    {
        return instance;
    }
}



