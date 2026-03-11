import { Controller, Get } from '@nestjs/common'

@Controller('health')
export class HealthController {
  @Get()
  check() {
    console.log(123)
    return { status: 'ok' }
  }
}
