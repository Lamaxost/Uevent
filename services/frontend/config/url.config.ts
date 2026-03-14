export const APP_URL = process.env.APP_URL as string

export const PUBLIC_URL = {
	home: () => '/',
	auth: () => '/auth',

	explorer: (query = '') => `/explorer${query ? `/${query}` : ''}`,

	event: (id = '') => `/event${id ? `/${id}` : ''}`,

	music: (id = '') => `/event/music${id ? `/${id}` : ''}`,

	festivals: (id = '') => `/event/festivals${id ? `/${id}` : ''}`,

	sport: (id = '') => `/event/sport${id ? `/${id}` : ''}`,

	clubs: (id = '') => `/event/clubs${id ? `/${id}` : ''}`,

	specialEvents: (id = '') => `/event/special-events${id ? `/${id}` : ''}`,

	standUp: (id = '') => `/event/stand-up${id ? `/${id}` : ''}`,

	artAndTheater: (id = '') => `/event/art-and-theater${id ? `/${id}` : ''}`,

	family: (id = '') => `/event/family${id ? `/${id}` : ''}`,

	profile: (id = '') => `/event/profile${id ? `/${id}` : ''}`
}
export const DASHBOARD_URL = {}

export const TICKET_MANAGEMENT_URL = {}
