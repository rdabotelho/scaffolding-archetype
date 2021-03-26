package ${context.basePackage};

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ${context.projectName.toPascalCase()}Application {

    public static void main(String[] args) {
        SpringApplication.run(${context.projectName.toPascalCase()}Application.class, args);
    }

}
