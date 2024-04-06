using System.Numerics;
using Raylib_cs;

namespace Onimon;

public class Player : IGameObject
{
    // the position of the player
    public Vector2 Position { get; set; }
    public Texture2D Sprite { get; set; }

    private int tileSize = 16;

    public Player(Vector2 pos)
    {
        Position = pos;
    }

    public void Init()
    {
        Sprite = Raylib.LoadTexture("../Assets/Player-Boy.png");
    }

    public void Update()
    {
        var newPosition = Position;

        if (Raylib.IsKeyPressed(KeyboardKey.Right)) newPosition.X += tileSize;
        if (Raylib.IsKeyPressed(KeyboardKey.Left)) newPosition.X -= tileSize;
        if (Raylib.IsKeyPressed(KeyboardKey.Up)) newPosition.Y -= tileSize;
        if (Raylib.IsKeyPressed(KeyboardKey.Down)) newPosition.Y += tileSize;

        // Position = newPosition;
        Raymath.Lerp(Position.X, newPosition.X, 1f);
    }


    public void Draw()
    {
        Vector2 sprSize = new Vector2(16, 16);

        Rectangle playerRect = new Rectangle(16, 0, sprSize);

        // draw the player
        Raylib.DrawTextureRec(Sprite, playerRect, Position, Color.White);
    }

}