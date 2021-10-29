using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class JumpCod : MonoBehaviour
{
    public float speed;//скорость персонажа
    public float jumpHeight;//высота прыжка перса
    private float keysInput;//отвечает за клавиши,которые мы нажимаем
    private Vector3 velocity = Vector3.zero;

    private Rigidbody2D rb;//нужен,чтобы обьекты воспринимали друг друга

    private bool isGrounded;//проверяет перс на земли чи нет
    public Transform groundCheck;//проверка есть  ли земля
    public float CheckRadius;//расс тояние от земли,на котором обновляется прыжок
    public LayerMask WhatIsGound;//спрашивается что такое земля(проверка наличия пола)

    private int MegaJump;
    public int MegaJumpValue;


    private void Start()

    {
        MegaJump = MegaJumpValue;
        rb = GetComponent<Rigidbody2D>();//говорит о том что тело может взаимодействовать с обьектами
    }



    private void FixedUpdate()
    {
        isGrounded = Physics2D.OverlapCircle(groundCheck.position,CheckRadius, WhatIsGound); //генерация окружности под ногами обьекта


        keysInput = Input.GetAxis("Horizontal");//отвечает за движение по горизонтали//если мы нажмем вправо, то наша переменная будет равняться +1,если влево то -1
        rb.velocity = new Vector2(keysInput * speed, rb.velocity.y);//velociti-вектор скорости тела.но тут мы делаем исключение на вектор2 так как движение по у на не нужны
        rb.velocity = Vector3.SmoothDamp(rb.velocity, velocity , ref velocity, speed);
                                         

    }

    private void Update()
    {
        if(isGrounded==true)
        {
            MegaJump = MegaJumpValue ;
        }
        if(Input.GetKeyDown(KeyCode.UpArrow)&& (MegaJump >0))//ввод название клавиши через которую будем вызыввать прыжок.
                                                             //Input.GetKeyDown вызывает метод который будет ждать нажатие клавиши,чтобы выполнить условие
        {
            rb.velocity = Vector3.up * jumpHeight;
            MegaJump--;
        }
        else if(Input.GetKeyDown(KeyCode.UpArrow) && (MegaJump==0) && (isGrounded ==true))
        {
            rb.velocity = Vector3.up * jumpHeight;
        }

    }
}
