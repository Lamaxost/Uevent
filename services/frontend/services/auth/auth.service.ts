import { axiosClassic } from '@/api/api.interceptors';
import { API_URL } from '@/config/api.config';
import { removeTokenFromStorage, saveTokenStorage } from './auth-token.service';


class AuthService {
    async getNewTokens() {
        const response = await axiosClassic({
            url: API_URL.auth('/refresh'),
            method: 'post'
        })

        if (response.data.accessToken) {
            saveTokenStorage(response.data.accessToken)
        }

        return response
    }

    async logout() {
        const response = await axiosClassic<boolean>({
            url: API_URL.auth('/logout'),
            method: 'post'
        })

        if (response.data) removeTokenFromStorage()
        return response
    }
}

export const authService = new AuthService()