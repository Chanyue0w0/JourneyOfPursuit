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
        var files = Directory.GetDirectories(Application.persistentDataPath);
        int currentFileSize = files.Length;

        string folderPath = Path.Combine(Application.persistentDataPath, currentFileSize.ToString());
        Debug.LogWarning("Folder Path: " + MainMenu.instance.folderPath);

        string json = JsonUtility.ToJson(fileManger);
        string fullPath = Path.Combine(MainMenu.instance.folderPath, fileName + ".json");
        Debug.LogWarning("Full Path: " +  fullPath);
        //string path = Application.persistentDataPath + "/" + currentFileSize.ToString() + "/" + fileName.ToString() + ".json";
        System.IO.File.WriteAllText(fullPath, json);
        travelogue = "";
        imagePathForStory = "";
    }

}
