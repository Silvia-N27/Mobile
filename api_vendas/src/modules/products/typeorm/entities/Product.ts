import { Column, CreateDateColumn, Entity, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";

@Entity("products") //tabela no banco é minusculo e plural
export default class Product{ //classe é so um produto ent por isso singular
    @PrimaryGeneratedColumn('uuid')
    id: string;
    @Column()
    name: string;
    @Column('decimal')
    price: number;
    @Column('int')
    quantity: number;
    @CreateDateColumn()
    created_at: Date;
    @UpdateDateColumn()
    updated_at: Date;
}