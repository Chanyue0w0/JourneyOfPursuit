using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;
using System;
using System.Threading;
using Unity.VisualScripting.FullSerializer;
using UnityEditor.PackageManager;

public class InkExternalFunctions
{
    public void BindPushEvent(Story story, List<Ink.Runtime.Path> events)
    {
        story.BindExternalFunction("PushEvent", (Ink.Runtime.Path a) =>
        {
            events.Add(a);
        });
    }

    public void UnbindPushEvent(Story story)
    {
        story.UnbindExternalFunction("PushEvent");
    }

    public void BindGetEvent(Story story, List<Ink.Runtime.Path> events)
    {
        story.BindExternalFunction("GetEvent", () =>
        {
            if (events.Count == 0)
            {
                Debug.Log("There is no event in bffer");
            }

            System.Random random = new System.Random(DateTime.Now.Millisecond);
            int ranNum = random.Next(0, 20231022) % events.Count;
            Debug.Log("Events: " + events.Count + " ranNum: " + ranNum);

            Path temp = events[ranNum];
            Debug.Log(temp.ToString());
            events.RemoveAt(ranNum);
            return temp;
        });
    }

    public void UnbindGetEvent(Story story)
    {
        story.UnbindExternalFunction("GetEvent");
    }

    public void BindClearEvent(Story story, List<Ink.Runtime.Path> events)
    {
        story.BindExternalFunction("ClearEvent", () =>
        {
            events.Clear();
        });
    }

    public void UnbindClearEvent(Story story)
    {
        story.UnbindExternalFunction("ClearEvent");
    }

    public void BindDiceResult(Story story, int strength, int agility, int charisma)
    {
        story.BindExternalFunction("DiceResult", (int difficultyLevel, string type) =>
        {
            System.Random random = new System.Random(DateTime.Now.Millisecond);
            int ranNum = random.Next(0, 20231022) % 20 + 1;
            Debug.Log("Type: " + type + " Dice: " + ranNum + " Strength: " + strength + " Agility: " + agility + " Charisma: " + charisma + " DifficultyLevel: " + difficultyLevel);

            if (type == "strength")
            {
                return ranNum + strength >= difficultyLevel;
            }
            else if (type == "agility")
            {
                return ranNum + agility >= difficultyLevel;
            }
            else if (type == "charisma")
            {
                return ranNum + charisma >= difficultyLevel;
            }

            return false;
        });
    }

    public void UnbindDiceResult(Story story)
    {
        story.UnbindExternalFunction("DiceResult");
    }

}