package org.ninjav.codeweaver;

import com.thoughtworks.qdox.JavaProjectBuilder;
import com.thoughtworks.qdox.model.JavaClass;
import com.thoughtworks.qdox.model.JavaMember;
import com.thoughtworks.qdox.model.JavaMethod;
import com.thoughtworks.qdox.model.JavaParameter;
import com.thoughtworks.qdox.model.JavaSource;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Freemarker cookie-cutter goodness.
 *
 */
public class App {

    public static void main(String[] args) throws Exception {
        String templateDir = null;
        String templateFile = null;
        String sourceFile = null;
        String outputFile = null;
        JavaProjectBuilder builder = new JavaProjectBuilder();
        Configuration cfg = new Configuration();
        Template template = null;

        if (args.length < 3) {
            System.out.println("Usage: cw -d ../templates -t class.ftl -s /path/to/Class.java -o outputFile other_src_files...");
            System.exit(1);
        }

        // Parse args
        for (int i = 0; i < args.length; i++) {
            if (args[i].equals("-d")) {
                templateDir = args[i + 1];
                cfg.setDirectoryForTemplateLoading(new File(templateDir));
                i += 1;
                //System.out.println("Using dir: " + templateDir);

            } else if (args[i].equals("-t")) {
                templateFile = args[i + 1];
                i += 1;
                //System.out.println("Using template: " + templateFile);
                template = cfg.getTemplate(templateFile);

            } else if (args[i].equals("-o")) {
                outputFile = args[i + 1];
                i += 1;
                //System.out.println("Using output: " + outputFile);

            } else if (args[i].equals("-s")) {
                sourceFile = args[i + 1];
                // Reading a single source file.
                builder.addSource(new FileReader(sourceFile));
                i += 1;
                //System.out.println("Using source: " + sourceFile);

            } else {
                //System.out.println("Adding source: " + args[i]);
                // Reading a single source file.
                builder.addSource(new FileReader(args[i]));
            }
        }

        try {
            // Load template from source folder
            //Template template = cfg.getTemplate("soapserver.ftl");

            // Build the data-model
            HashMap<String, JavaClass> data = new HashMap<String, JavaClass>();
            data.put("class", builder.getClasses().toArray(new JavaClass[]{})[0]);
            
            for (JavaClass clazz : builder.getClasses()) {
                data.put(clazz.getName(), clazz);
            }

            if (outputFile == null || outputFile.isEmpty()) {
                // Console output
                template.process(data, new OutputStreamWriter(System.out));
            } else {
                // File output
                Writer file = new FileWriter(new File(outputFile));
                template.process(data, file);
                file.flush();
                file.close();
            }

        } catch (IOException e) {
            e.printStackTrace();
        } catch (TemplateException e) {
            e.printStackTrace();
        }
    }
}

/*
 for (JavaClass jc : builder.getClasses()) {
 System.out.println("Class: " + jc.getName());
            
 for (JavaMethod jm : jc.getMethods()) {
 System.out.println("  Method: " + jm.getName());
 System.out.println("  Type: " + jm.getReturnType().getValue());
                
 for (JavaParameter jp : jm.getParameters()) {
 System.out.println("     Param: " + jp.getName());
 System.out.println("     Type: " + jp.getType().getValue());
 }
 }
 }
 */
/*        
 // creates an input stream for the file to be parsed
 FileInputStream in = new FileInputStream(args[0]);

 CompilationUnit cu;
 try {
 // parse the file
 cu = JavaParser.parse(in);
 } finally {
 in.close();
 }

 // prints the resulting compilation unit to default system output
 //System.out.println(cu.toString());
 System.out.println("Package: " + cu.getPackage());
 for (TypeDeclaration t : cu.getTypes()) {
 System.out.println("  Type: " + t.getName());
 for (BodyDeclaration b : t.getMembers()) {
 if (b instanceof MethodDeclaration) {
 MethodDeclaration method = (MethodDeclaration) b;
                    
 System.out.println("     Method: " + method.getName());
 System.out.println("     Type: " + method.getType());

 for (Parameter p : method.getParameters()) {
 System.out.println("       Parameter: " + p.getId());
 }
 }
 }
 }
 */
