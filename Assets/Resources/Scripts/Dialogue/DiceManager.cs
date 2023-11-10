using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DiceManager : MonoBehaviour
{
    public GameObject dice;
    public Animator anim;

    public static DiceManager instance;
    // Start is called before the first frame update
    void Awake()
    {
        if (instance != null)
        {
            Debug.LogWarning("Found more than one Dice Manager in the scene");
        }
        instance = this;
    }

    public static DiceManager GetInstance()
    {
        return instance;
    }

    // Update is called once per frame
    void Update()
    {
    }
}
