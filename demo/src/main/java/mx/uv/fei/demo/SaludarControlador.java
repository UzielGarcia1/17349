package mx.uv.fei.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SaludarControlador{

    @GetMapping("/getSaludo")
    public String saludar(){
        return "Hola mundo!";
    }

    @GetMapping("xxxDespedida")
    public String adios(){
        return "Adios mundo!";
    }
}