using System.Numerics;
using Raylib_cs;
using static Raylib_cs.Raylib;

namespace Onimon;

class Program
{
    public static Player Player {get; set;}

    public static void Main()
    {
        Player = new Player(new Vector2(100, 100));
        InitWindow(800, 480, "Hello World");
        SetTargetFPS(60);

        Init();

        while (!Raylib.WindowShouldClose())
        {
            Update();
            Draw();
        }

        Raylib.CloseWindow();
    }

    static void Init()
    {
        Player.Init();
    }

    static void Update()
    {
        Player.Update();
    }

    static void Draw()
    {
        BeginDrawing();
        ClearBackground(Color.White);

        DrawText("Hello, world!", 12, 12, 20, Color.Black);

        Player.Draw();

        EndDrawing();
    }

}