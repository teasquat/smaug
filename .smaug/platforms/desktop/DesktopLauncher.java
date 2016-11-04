package %PACKAGE%.desktop;

import java.io.File;
import java.io.InputStream;
import java.io.FileInputStream;
import java.util.Map;
import org.yaml.snakeyaml.Yaml;
import com.badlogic.gdx.Files;
import com.badlogic.gdx.backends.lwjgl.LwjglApplication;
import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration;

import smaug.SmaugVM;

public class DesktopLauncer {
  @SuppressWarnings("unchecked")
  public static void main(String[] args) {
    LwjglApplicationConfiguration cfg = new LwjglApplicationConfiguration();

    cfg.addIcon("smaug/icon-256.png", Files.FileType.Internal);
    cfg.addIcon("smaug/icon-192.png", Files.FileType.Internal);
    cfg.addIcon("smaug/icon-64.png",  Files.FileType.Internal);
    cfg.addIcon("smaug/icon-32.png",  Files.FileType.Internal);
    cfg.addIcon("smaug/icon-16.png",  Files.FileType.Internal);

    cfg.forceExit = false;
    cfg.width     = 800;
    cfg.height    = 600;
    cfg.resizable = false;

    Yaml yaml = new Yaml();
    Map config;

    try {
      config = (Map<String, Object>) yaml.load(DesktopLauncer.class.getResourceAsStream("/smaug/_config.yml"));

    } catch(Exception e) {
      try {
        config = (Map<String, Object>) yaml.load(new FileInputStream(new File("smaug/_config.yml")));

      } catch (Exception e1) {
        System.err.println(e1.getMessage());
        System.exit(-1);

        return;
      }
    }

    cfg.title = (String) config.get("name");

    if (config.containsKey("window")) {
      Map window = (Map<String, Object>) config.get("window");

      if (window.containsKey("width")) {
        cfg.width = (int) window.get("width");
      }

      if (window.containsKey("height")) {
        cfg.height = (int) window.get("height");
      }

      if (window.containsKey("resizable")) {
        cfg.resizable = (boolean) window.get("resizable");
      }

      if (window.containsKey("fullscreen")) {
        cfg.fullscreen = (boolean) window.get("fullscreen");
      }
    }

    new LwjglApplication(new SmaugVM(config), cfg);
  }
}
