<#compress>
<#assign className = class.name?replace("Operations", "")>
<#assign classPackage = class.package?replace("package ", "")>
<#assign classNameQualifier = class.name?replace("SOOperations", "")>
<#assign classNameQualifier = classNameQualifier?replace("Operations", "")>
<#assign classNameQualifier = classNameQualifier + "Qualifier">
</#compress>
package com.ebucks.corba.client;

import java.util.logging.Logger;
import javax.enterprise.inject.Produces;
import javax.enterprise.inject.spi.InjectionPoint;
import javax.inject.Inject;
import ${classPackage}.${className};
import ${classPackage}.${className}Helper;
import org.omg.CORBA.UserException;
import org.omg.CosNaming.NameComponent;
import org.omg.CosNaming.NamingContextExt;

/**
 * Uses CDI producer as a factory method for injecting CORBA ${className} service.
 * This forms the foundation for surfacing eBucks CORBA core to WSDL.
 *
 * @author F4715705
 */
public class ${className}Factory {

    @Inject
    private Logger log;
    
    @Inject
    private NamingContextExt namingContext;
    
    @Produces
    @${classNameQualifier}
    public ${className} produce${className}CorbaClient(InjectionPoint injectionPoint) 
            throws Exception {
       try {
            return ${className}Helper.narrow(
                    namingContext.resolve(
                        new NameComponent[]{new NameComponent("${classNameQualifier}", "")}));
        } catch (UserException ue) {
            throw new Exception(ue);
        }
    }
}
