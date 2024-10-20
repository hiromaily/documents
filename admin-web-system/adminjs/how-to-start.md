# How to start Adminjs

## Spec

- adminjs: 7.7
- prisma: 5.6
- Typescript: 5.0

## Procedure

### 1. Setup

1. Run first command

    ```sh
    npx adminjs create
    ```

2. Design database schema / environment

3. Modify `admin/.env` if needed

    ```sh
    DATABASE_URL=postgresql://alcoholic:secret@localhost:5432/beer?schema=public
    DATABASE_DIALECT=postgresql
    DATABASE_NAME=beer
    DATABASE_HOST=localhost
    DATABASE_USER=alcoholic
    DATABASE_PASSWORD=secret
    ```

4. Create DDL for database by sql then apply it on Database

    ```sql
    CREATE TABLE BeerTypes (
        id SERIAL PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        description TEXT,
        category BeerCategory NOT NULL
    );
    COMMENT ON TABLE BeerTypes IS 'Beer types table';
    COMMENT ON COLUMN BeerTypes.id IS 'beer type id';
    COMMENT ON COLUMN BeerTypes.name IS 'beer type name';
    COMMENT ON COLUMN BeerTypes.description IS 'beer type explanation';
    COMMENT ON COLUMN BeerTypes.category IS 'beer type category';
    ```

5. Add useful prisma modules

    ```sh
    npm install --save-dev @onozaty/prisma-db-comments-generator prisma-case-format
    ```

6. Run prisma command to generate `schema.prisma`

    ```sh
    npx prisma db pull
    npx prisma generate
    ```

7. Modify `schema.prisma` if needed

8. Regenerate migration files as development

    ```sh
    npx prisma migrate dev --name init
    npx prisma generate
    ```

### 2. Code

1. Code [Adapter for prisma](https://docs.adminjs.co/installation/adapters/prisma) (DBのModelの設定)

    modify `admin/options.ts`

    ```ts
    import { AdminJS, AdminJSOptions } from 'adminjs';
    import { Database, Resource, getModelByName } from '@adminjs/prisma';
    import { PrismaClient } from '@prisma/client';

    import componentLoader from './component-loader.js';

    // Prisma
    const prisma = new PrismaClient();
    AdminJS.registerAdapter({ Database, Resource });

    const resources = [{
    resource: { model: getModelByName('Beers'), client: prisma },
    options: {},
    }, {
    resource: { model: getModelByName('BeerTypes'), client: prisma },
    options: {},
    }];

    const options: AdminJSOptions = {
    componentLoader,
    rootPath: '/admin',
    resources,
    databases: [],
    };

    export default options;
    ```

2. Code [Authentication](https://docs.adminjs.co/basics/authentication) logic

    modify `admin/auth-provider.ts`

    ```ts
    const provider = new DefaultAuthProvider({
    componentLoader,
    authenticate: async ({ email, password }) => {
        if (email === DEFAULT_ADMIN.email) {
        return { email };
        }

        return null;
    },
    });
    ```

    supabaseによる認証

    ```ts
    const provider = new DefaultAuthProvider({
    componentLoader,
    authenticate: async ({ email, password }) => {
        // use supabase
        const supabaseUrl = process.env.SUPABASE_URL;
        const supabaseKey = process.env.SUPABASE_KEY;
        const supabase = createClient(supabaseUrl, supabaseKey);
        // sign in
        const res = await supabase.auth.signInWithPassword({
        email,
        password,
        });
        if (res.error) return null;

        return { email };
    },
    });
    ```

## Run Adminjs

1. Run adminjs

    ```sh
    npm run build
    npm run start
    ```

2. Access to `http://localhost:3000/admin`

    Email and Password is in `src/admin/constants.ts`

    ```ts
    export const DEFAULT_ADMIN = {
        email: 'admin@example.com',
        password: 'password',
    };
    ```
