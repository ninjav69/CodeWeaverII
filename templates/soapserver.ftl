<#compress>
<#assign className = class.name?replace("Operations", "")>
<#assign classPackage = class.package?replace("package ", "")>
<#assign classNameQualifier = class.name?replace("SOOperations", "")>
<#assign classNameQualifier = classNameQualifier?replace("Operations", "")>
<#assign classNameQualifier = classNameQualifier + "Qualifier">
</#compress>
package com.ebucks.soap;

import ${classPackage}.${className};
import com.ebucks.corba.client.${classNameQualifier};
import javax.inject.Inject;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;

@WebService
public class ${className}WS {
    @Inject
    @${classNameQualifier}
    private ${className} delegate;

    <#list class.methods as method>
    @WebMethod(operationName = "${method.name}")
    public ${method.returnType.value}<#if method.returnType.array>[]</#if> ${method.name}  (<#rt>
        <#list method.parameters as param>
        <#lt>@WebParam(name = "${param.name}") ${param.type.value}<#if param.type.array>[]</#if> ${param.name}<#if param_has_next>,</#if><#rt>
        </#list>
    <#lt>) <#if method.exceptions?has_content> throws ${method.exceptions?join(", ")} </#if> {
        <#if method.returnType != "void">
        return delegate.${method.name}(<#rt>
        <#else>
        delegate.${method.name}(<#rt>
        </#if>
            <#list method.parameters as param>
            <#lt>${param.name}<#if param_has_next>,</#if><#rt>
            </#list><#lt>);
    }
    </#list>
}

