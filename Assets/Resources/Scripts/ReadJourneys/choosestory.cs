using System;
using System.IO;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using Newtonsoft;
using Newtonsoft.Json;

public class choosestory : MonoBehaviour
{

    //public Button storys = new Button[6];
    //public Text ts = new Text[6];

    string[] tales = Directory.GetFiles(".//Assets/Resources/journeys");
    // Start is called before the first frame update
    void Start()
    {
        /*
        for(int i = 0;i<sizeof(tales)/sizeof(string);i+=2){
            ts.text = tales[i];
        }
        for(int i = sizeof(tales)/sizeof(string);i<12;i+=2){
            ts.text = "";
        }
        */
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
