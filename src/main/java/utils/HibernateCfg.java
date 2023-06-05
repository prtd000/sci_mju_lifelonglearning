package utils;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

public class HibernateCfg {
    public static Session openSession(String hibernateCfg) {
        final StandardServiceRegistry registry = new StandardServiceRegistryBuilder()
                .configure(hibernateCfg)
                .build();
        SessionFactory sessionFactory = new MetadataSources(registry)
                .buildMetadata()
                .buildSessionFactory();
        return sessionFactory.openSession();
    }
}


	

