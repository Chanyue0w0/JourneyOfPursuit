using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.IO;

public class FileManager
{
    public int fileName;
    public string travelogue;
    public string imagePathForStory;

    public FileManager()
    {
        fileName = 0;
        travelogue = "";
        imagePathForStory = "";
    }

    public void SaveFile(FileManager fileManger)
    {
        string json = JsonUtility.ToJson(fileManger);
        string path = Application.dataPath + "/Resources/journeys/" + fileName.ToString() + ".json";
        System.IO.File.WriteAllText(path, json);
        travelogue = "";
        imagePathForStory = "";
    }

}
