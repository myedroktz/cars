dataSource {
    pooled = true
    jmxExport = true
    driverClassName = "com.mysql.jdbc.Driver"//"org.h2.Driver"
    username = "root"
    password = "admin"
    dialect = org.hibernate.dialect.MySQL5InnoDBDialect
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
//    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
    singleSession = true // configure OSIV singleSession mode
}

// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            url =  "jdbc:mysql://localhost:3306/carsDatabase"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url =  "jdbc:mysql://localhost:3306/carsDatabase"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url =  "jdbc:mysql://localhost:3306/carsDatabase"
            properties {
                maxActive = -1
                minEvictableIdleTimeMillis=1800000
                timeBetweenEvictionRunsMillis=1800000
                numTestsPerEvictionRun=3
                testOnBorrow=true
                testWhileIdle=true
                testOnReturn=false
                validationQuery="SELECT 1"
                jdbcInterceptors="ConnectionState"
            }
        }
    }
}
