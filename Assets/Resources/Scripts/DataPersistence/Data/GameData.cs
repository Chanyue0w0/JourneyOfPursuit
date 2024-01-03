using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.UI;

public class GameData
{
    public int HP;
    public int money;
    public int morality;
    public int strength;
    public int agility;
    public int charisma;

    public string dialogueText;
    public string displayNameText;
    public string imagePath;
    public string storyPath;

    public bool diceRolling;

    public int fileName;
    public string travelogue;
    public string imagePathForStory;
    public string folderPath;

    public float BGMTime;
    public string currBGM;
    public float musicTime;
    public string currMusic;

    public GameData(string chapter)
    {
        HP = 40;
        money = 0;
        morality = 5;
        strength = 0;
        agility = 0;
        charisma = 0;

        dialogueText = "";
        displayNameText = "";
        imagePath = "";
        storyPath = "Events/" + chapter;

        diceRolling = false;

        fileName = 0;
        travelogue = "";
        imagePathForStory = "";

        currBGM = "forest";
        BGMTime = 0;
        currMusic = "none";
        musicTime = 0;
    }
}
