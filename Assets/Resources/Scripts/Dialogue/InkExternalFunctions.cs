using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using Ink.Runtime;
using System;
using System.Threading;
using System.Threading.Tasks;
using Unity.VisualScripting.FullSerializer;

public class InkExternalFunctions
{
    public int randvalue = 0;
    public string typeD;
    public int strengthD;
    public int agilityD;
    public int charismaD;
    public int difficultyLevelD;
    public void BindAll(Story story, List<Ink.Runtime.Path> events, int strength, int agility, int charisma)
    {
        BindPushEvent(story, events);
        BindGetEvent(story, events);
        BindClearEvent(story, events);
        BindDiceResult(story, strength, agility, charisma);
    }

    public void UnBindAll(Story story)
    {
        UnbindPushEvent(story);
        UnbindGetEvent(story);
        UnbindClearEvent(story);
        UnbindDiceResult(story);
    }

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
            randvalue = ranNum;
            typeD = type;
            strengthD = DialogueManager.GetInstance().strength;
            agilityD = DialogueManager.GetInstance().agility;
            charismaD = DialogueManager.GetInstance().charisma;
            difficultyLevelD = difficultyLevel;

            DialogueManager.GetInstance().diceNum = ranNum;
            //DiceManager.GetInstance().anim.SetInteger("DiceResult", ranNum);

            Debug.Log("Type: " + type + " Dice: " + ranNum + " Strength: " + strength + " Agility: " + agility + " Charisma: " + charisma + " DifficultyLevel: " + difficultyLevel);

            if (ranNum >= 20)
            {
                return true;
            }
            else if (ranNum <= 1)
            {
                return false;
            }
            else if (type == "strength")
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
