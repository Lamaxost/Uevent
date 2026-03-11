import { Module } from '@nestjs/common'

import { TypeOrmModule } from '@nestjs/typeorm'

import { ConfigModule } from '@nestjs/config'
import { AuthModule } from './auth/auth.module'
import { UserModule } from './user/user.module'
import { HealthModule } from './health/health.module'

import typeOrmConfig from './config/typeorm.config'

@Module({
	imports: [
		ConfigModule.forRoot(),
		AuthModule,
		UserModule,
		HealthModule,
		TypeOrmModule.forRoot(typeOrmConfig as any),
	],
})
export class AppModule {}
