<#compress>
<#assign className = class.name>
<#if (class.package)??>
<#assign classPackage = class.package?replace("package ", "")>
</#if>
</#compress>

public interface ${className} {

    <#list class.fields as field>
        <#if field.type?starts_with("com.mypackage")>
        <#assign subClass = field.type>
        ${subClass.package} ${subClass.name} {
            <#list subClass.fields as field>
                ${field.type} ${field.name};
            </#list>
        }
        <#else>
            ${field.type} ${field.name};
        </#if>
    </#list>

    <#list class.methods as method>
    public ${method.returnType.value}<#if method.returnType.array>[]</#if> ${method.name}  (<#rt>
        <#list method.parameters as param>
        <#lt>${param.type.value}<#if param.type.array>[]</#if> ${param.name}<#if param_has_next>,</#if><#rt>
        </#list>
    <#lt>) <#if method.exceptions?has_content> throws ${method.exceptions?join(", ")}</#if> ;
    </#list>
}

