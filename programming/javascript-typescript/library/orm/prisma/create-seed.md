# PrismaのSeedの作成

1. package.jsonに、`seed`を追加

    ```json
      "prisma": {
        "schema": "prisma/schema.prisma",
        "seed": "tsx src/seeds/index.ts"
      },
    ```

2. [tsx](https://github.com/privatenumber/tsx)といったtypescriptコードを実行できるpakcageをインストール

3. seed用のコードを作成

    ```ts
    import { PrismaClient } from '@prisma/client';

    import { seedCountries } from './countries.js';
    import { seedBeerTypes } from './beer-types.js';

    // https://www.prisma.io/docs/orm/prisma-migrate/workflows/seeding

    const prisma = new PrismaClient();

    async function main() {
      await seedCountries(prisma);
      await seedBeerTypes(prisma);
    }

    main()
      .then(async () => {
        await prisma.$disconnect();
        process.exit(0);
      })
      .catch(async (e) => {
        console.error(e);
        await prisma.$disconnect();
        process.exit(1);
      });
    ```

    ```ts
    import { PrismaClient } from '@prisma/client';

    export async function seedCountries(prisma: PrismaClient) {
      await prisma.countries.createMany({
        data: [
          {
            code: 'JP',
            nameEn: 'Japan',
            nameJa: '日本',
          },
          {
            code: 'US',
            nameEn: 'United States',
            nameJa: 'アメリカ',
          },
          {
            code: 'NL',
            nameEn: 'Netherlands',
            nameJa: 'オランダ',
          },
          {
            code: 'DE',
            nameEn: 'Germany',
            nameJa: 'ドイツ',
          },
        ],
      });
    }
    ```
