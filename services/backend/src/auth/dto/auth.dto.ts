import { z } from 'zod'

export const LoginDto = z.object({
	email: z.email().optional(),
	password: z.string().min(6).max(100)
})

export const RegisterDto = z.object({
	username: z.string().min(3).max(20),
	email: z.email(),
	password: z.string().min(6).max(100),
	confirmPassword: z.string().min(6).max(100)
})

export type LoginDto = z.infer<typeof LoginDto>
export type RegisterDto = z.infer<typeof RegisterDto>
