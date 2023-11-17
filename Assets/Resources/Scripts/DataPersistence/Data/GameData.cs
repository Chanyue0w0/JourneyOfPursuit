using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using UnityEditor.PackageManager;
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

    public GameData()
    {
        HP = 100;
        money = 0;
        morality = 0;
        strength = 10;
        agility = 10;
        charisma = 10;

        dialogueText = "";
        displayNameText = "";
        imagePath = "";
        storyPath = "Events/Kindom";

        diceRolling = false;

        fileName = 0;
        travelogue = "";
        imagePathForStory = "";
    }
}
