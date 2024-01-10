import NextAuth from "next-auth"
import type { NextAuthConfig } from "next-auth"
import GitHub from "next-auth/providers/github"

export const authConfig = {
    theme: {
        logo: "",
    },
    providers: [
        GitHub,
    ],
    callbacks: {
        authorized( { auth } ) {
            return !!auth
        },
    },
} satisfies NextAuthConfig

export const { handlers, auth, signIn, signOut } = NextAuth( authConfig )
