using System.Numerics;
using Raylib_cs;

namespace Onimon;

public interface IGameObject
{
    public Texture2D Sprite { get; set; }
    public Vector2 Position { get; set; }
    public void Init();
    public void Update();
    public void Draw();
}