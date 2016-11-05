package smaug;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.GlyphLayout;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.BitmapFont;
import com.badlogic.gdx.graphics.Texture.TextureFilter;
import com.badlogic.gdx.graphics.g2d.freetype.FreeTypeFontGenerator;
import com.badlogic.gdx.math.Vector2;
import com.badlogic.gdx.utils.Disposable;

@SuppressWarnings("deprecation")
public class LoadingScreen implements Disposable {
  private final SpriteBatch batch;
  private final BitmapFont font;
  private final Sprite icon;
  private final GlyphLayout glyphs = new GlyphLayout();
  private final Color color;

  private String text = "";

  public LoadingScreen() {
    batch = new SpriteBatch();

    font = new FreeTypeFontGenerator(Gdx.files.internal("smaug/font.ttf")).generateFont(16);
    font.getRegion(0).getTexture().setFilter(TextureFilter.Linear, TextureFilter.Linear);

    Texture icon_tex = new Texture(Gdx.files.internal("smaug/icon.png"));

    if (!icon_tex.getTextureData().isPrepared()) {
      icon_tex.getTextureData().prepare();
    }

    color = new Color(icon_tex.getTextureData().consumePixmap().getPixel(0, 0));

    icon = new Sprite(icon_tex);
    icon.setOrigin(0, 0);
  }

  public void render() {
    Gdx.gl.glClearColor(color.r, color.g, color.b, 1);
    Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);

    batch.begin();

    icon.draw(batch);

    font.draw(batch, text,
      (Gdx.graphics.getWidth()  - glyphs.width)  / 2,
      (Gdx.graphics.getHeight() - glyphs.height) / 2
    );

    batch.end();
  }

  public void resize(int width, int height) {
    batch.setProjectionMatrix(batch.getProjectionMatrix().setToOrtho2D(0, 0, width, height));
    icon.setPosition((width - icon.getWidth()) / 2, (height - icon.getHeight()) / 2);
  }

  public void set_text(String text) {
    this.text = text;

    glyphs.setText(font, text);
  }

  @Override
  public void dispose() {
    batch.dispose();
    font.dispose();
  }
}
