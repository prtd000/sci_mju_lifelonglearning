package runpackage;

import org.hibernate.Session;

import utils.HibernateCfg;

public class RunApp {

	public static void main(String[] args) {
		Session session = HibernateCfg.openSession("hibernate.cfg.xml");


		try {
			session.beginTransaction();
			session.getTransaction().commit();
			session.beginTransaction();
			session.getTransaction().commit();
		} catch (Exception e) {

		} finally {
			if (session.getTransaction().isActive()) {
				session.getTransaction().rollback();
			}
			session.close();
		}
	}

}
