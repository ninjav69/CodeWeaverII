<#compress>
<#assign classNameQualifier = class.name?replace("SOOperations", "")>
<#assign classNameQualifier = classNameQualifier?replace("Operations", "")>
<#assign classNameQualifier = classNameQualifier + "Qualifier">
</#compress>
package com.ebucks.corba.client;

import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.PARAMETER;
import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import javax.inject.Qualifier;

/**
 *
 * @author F4715705
 */
@Qualifier
@Retention(RUNTIME)
@Target({METHOD, FIELD, PARAMETER, TYPE})
public @interface ${classNameQualifier} {
}
