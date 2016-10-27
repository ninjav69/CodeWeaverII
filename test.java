package com.ebucks.corba.client;

import java.util.logging.Logger;
import javax.enterprise.inject.Produces;
import javax.enterprise.inject.spi.InjectionPoint;
import javax.inject.Inject;
import com.ebucks.UserManagerSO.UserManagerSO;
import com.ebucks.UserManagerSO.UserManagerSOHelper;
import org.omg.CORBA.UserException;
import org.omg.CosNaming.NameComponent;
import org.omg.CosNaming.NamingContextExt;

/**
 * Uses CDI producer as a factory method for injecting CORBA UserManagerSO service.
 * This forms the foundation for surfacing eBucks CORBA core to WSDL.
 *
 * @author F4715705
 */
public class UserManagerSOFactory {

    @Inject
    private Logger log;
    
    @Inject
    private NamingContextExt namingContext;
    
    @Produces
    @UserManagerQualifier
    public UserManagerSO produceUserManagerSOCorbaClient(InjectionPoint injectionPoint) 
            throws Exception {
       try {
            return UserManagerSOHelper.narrow(
                    namingContext.resolve(
                        new NameComponent[]{new NameComponent("UserManagerQualifier", "")}));
        } catch (UserException ue) {
            throw new Exception(ue);
        }
    }
}
