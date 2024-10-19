# How to start Adminjs

## Spec

- adminjs: 7.7
- prisma: 5.6

## Procedure

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

9. Run adminjs

    ```sh
    npm run start
    ```

10. Access to `http://localhost:3000/admin`

    Email and Password is in `src/admin/constants.ts`

    ```ts
    export const DEFAULT_ADMIN = {
        email: 'admin@example.com',
        password: 'password',
    };
    ```
