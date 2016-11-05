package smaug;

import java.lang.reflect.Field;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Application.ApplicationType;
import com.badlogic.gdx.files.FileHandle;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;

public class Helpers {
  private boolean is_running_ouya;

  public Helpers() {
    try {
      Field field = Class.forName("android.os.Build").getDeclaredField("DEVICE");
      Object device = field.get(null);

      is_running_ouya = "ouya_1_1".equals(device) || "cardhu".equals(device);

    } catch (Exception e) {
      // awwh
    }
  }

  public FileHandle local_file(String name) {
    return Gdx.files.local(name);
  }

  public String get_OS() {
    String name = "unknown";

    if (Gdx.app.getType() == ApplicationType.Desktop) {
      String os_name = System.getProperty("os.name").toLowerCase();

      if (os_name.startsWith("windows")) {
        name = "Windows";
      } else if (os_name.startsWith("linux")) {
        name = "Linux";
      } else if (os_name.startsWith("mac") || os_name.startsWith("darwin")) {
        name = "OS X";
      } else if (os_name.startsWith("sunos")) {
        name = "Solaris";
      }

    } else if (Gdx.app.getType() == ApplicationType.Android) {
      name = "Android";

    } else if (Gdx.app.getType() == ApplicationType.iOS) {
      name = "iOS";

    } else if (is_running_ouya) {
      name = "Ouya";
    }

    return name;
  }

  public void end_Batch(SpriteBatch batch) {
    batch.end();
  }

  public void end_shapes(ShapeRenderer shapes) {
    shapes.end();
  }
}
