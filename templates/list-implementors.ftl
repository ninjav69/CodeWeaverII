All classes implementing ${class.name}
<#list builder.classes as clazz>
    <#list clazz.implements as impl>
        <#if impl.name == class.name>
${clazz.package.name}.${clazz.name}
        </#if>
    </#list>
</#list>
