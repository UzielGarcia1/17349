package mx.uv.fei.demo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PlantillaControlador {
    
    @RequestMapping("/plantilla")
    public String plantilla(Model modelo){
        modelo.addAttribute("mensaje", "Hola mundo");
        return "pagina";
    }
}
